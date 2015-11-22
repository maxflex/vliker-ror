require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let (:task_url) { 'https://vk.com/wall316834465_6' }

  before(:each) do
    post :blocks, {url: task_url}, format: :json
    expect(response.status).to eq(200)
  end

  describe '#blocks' do
    it 'gets 6 new tasks' do
      expect(response_json['current_task']).to be_present
      expect(response_json['tasks'].length).to eq(6)
    end

    it "changes user's last seen task" do
      max_task = response_json['tasks'].max_by {|t| t['id']}
      expect(session[:user]['last_seen_task']).to eq(max_task['id'])
    end
  end

  describe '#get_new' do
    it "gets user's next task and updates last_seen_task" do
      last_seen_task = session[:user]['last_seen_task']

      post :get_new, format: :json
      expect(response.status).to eq(200)

      # expect the next task
      expect(response_json['id'] - last_seen_task).to eq(1)

      # user's last_seen_task should change
      expect(session[:user]['last_seen_task']).to eq(last_seen_task + 1)
    end

    it "seen all tasks and doesn't update last_seen_task" do
      last_seen_task = session[:user]['last_seen_task'] = Task.last.id

      post :get_new, format: :json
      expect(response.status).to eq(200)

      expect(response.body).to eq('null')
      expect(session[:user]['last_seen_task']).to eq(last_seen_task)
    end
  end

  describe '#stop' do
    # stops vliker with data
    def post_stop_data
      @task_data ||= [
        {'id' => 1, 'ts' => 1250, 'ce' => '0x000'},
        {'id' => 2, 'ts' => 1500, 'ce' => '0x000'},
        {'id' => 3, 'ts' => (2.minutes * 1000), 'ce' => '0x000'},
      ]

      @task_report_ids ||= [4, 5]

      post :stop, task_data: @task_data, task_report_ids: @task_report_ids, format: :json
    end

    it 'adds likes and de-activates if needed reached' do
      # first task has one more like before finished
      Task.update(1, likes: Task.first.need - 1)

      # tasks before they are being liked
      tasks = Task.first(3)

      post_stop_data

      # tasks after they are being liked by #STOP
      tasks_after_likes = Task.first(3)

      tasks.each_with_index do |task, index|
        expect(tasks_after_likes[index].likes - task.likes).to eq(1)
      end

      # expect first task to be finished
      expect(Task.first.active).to be false
    end

    it 'adds reports and de-activates with 3 or more reports' do
      # task with id of 4 has one more report before de-activated
      Task.update(4, reports: 2)

      tasks = Task.find([4, 5])

      post_stop_data

      tasks_after_reports = Task.find([4, 5])

      tasks.each_with_index do |task, index|
        expect(tasks_after_reports[index].reports - task.reports).to eq(1)
      end

      # task with id=4 should now be de-activated
      expect(Task.find(4).active).to be false
    end

    it 'creates a new user and saves last_seen_task' do
      user_count_before_stop = User.count

      post_stop_data

      expect(User.count - user_count_before_stop).to eq(1)
      expect(User.last[:last_seen_task]).to eq(6) # because received 6 blocks
    end
  end

  def response_json
    @response_json ||= JSON.parse(response.body)
  end
end
