require 'rails_helper'

RSpec.describe Task, type: :model do
  let (:task_ids) { [1, 2, 3] }
  let (:task_url) { 'https://vk.com/wall316834465_6' }

  context '#like' do
    it 'adds a new task' do
      user = User.create

      task = user.tasks.build(url: task_url)
      task.add_needed(5)

      just_saved_task = Task.last
      expect(just_saved_task).to have_attributes(
        :need    => 5,
        :active  => true,
        :queue   => 10,
        :user_id => user.id
      )
    end

    it 'doesnt activate a new task with less than 3 likes' do
      user = User.create

      task = user.tasks.build(url: task_url)
      task.add_needed(2)

      expect(task.active).to be false
    end

    it 'likes other tasks' do
      # get tasks before they are liked
      tasks = Task.find(task_ids)

      # like tasks
      Task.like_others(task_ids)

      # get liked tasks and store in another variable
      liked_tasks = Task.find(task_ids)

      tasks.each_with_index do |task, index|
        # expect likes to increase
        expect(liked_tasks[index].likes).to be > task.likes
      end
    end

    context '#validation' do
      it 'has correct params' do
        task_data = [
          {'id' => 1, 'ts' => 1250, 'ce' => '0x000'},
          {'id' => 1, 'ts' => 1500, 'ce' => '0x000'},
          {'id' => 1, 'ts' => (2.minutes * 1000), 'ce' => '0x000'},
        ]
        valid_task_ids = Task.verify_likes(task_data)

        expect(valid_task_ids.length).to eq(task_data.length)
      end

      it 'fails if time is less than 1.25 seconds' do
        task_data = [
          {'id' => 1, 'ts' => 1249, 'ce' => '0x000'},
          {'id' => 1, 'ts' => 1000, 'ce' => '0x000'},
          {'id' => 1, 'ts' => 500, 'ce' => '0x000'},
        ]
        valid_task_ids = Task.verify_likes(task_data)

        expect(valid_task_ids.length).to eq(0)
      end

      it 'fails if time is greater than 2 minutes' do
        task_data = [
          {'id' => 1, 'ts' => (2.minutes * 1000 + 1), 'ce' => '0x000'},
          {'id' => 1, 'ts' => (3.minutes * 1000), 'ce' => '0x000'},
          {'id' => 1, 'ts' => (1.hour * 1000), 'ce' => '0x000'},
        ]
        valid_task_ids = Task.verify_likes(task_data)

        expect(valid_task_ids.length).to eq(0)
      end

      it 'fails if core_engine is incorrect' do
        task_data = [
          {'id' => 1, 'ts' => 1250},
          {'id' => 1, 'ts' => 1500, 'ce' => 'INCORRECT_CORE_ENGINE'},
          {'id' => 1, 'ts' => (2.minutes * 1000), 'ce' => '3x333'},
        ]

        valid_task_ids = Task.verify_likes(task_data)

        expect(valid_task_ids.length).to eq(0)
      end
    end
  end

  context '#reports' do
    it 'increases reports count' do
      # get task before report
      tasks = Task.find(task_ids)

      # report tasks
      Task.report(task_ids)

      # get tasks after report and store in another variable
      reported_tasks = Task.find(task_ids)

      # compare before and after variables
      tasks.each_with_index do |task, index|
        # expect reports to increase
        expect(reported_tasks[index].reports).to be > task.reports
      end
    end

    it 'de-activates a task with 3 or more reports' do
      # set the initial reports of 2
      Task.where(id: task_ids).update_all(reports: 2)

      # report tasks
      Task.report(task_ids)

      # expect them to be de-activated
      Task.find(task_ids).each do |task|
        expect(task.active).to be false
      end
    end
  end

  context '#queue' do
    it 'updates queue' do
      queue_before = Task.last.queue

      # reduce queue by  task_ids.length (3)
      Task.where(id: task_ids).update_all(active: false)

      # update queue
      Task.last.update_queue
      
      queue_after = Task.last.queue

      expect(queue_before - queue_after).to eq(task_ids.length)
    end
  end
end
