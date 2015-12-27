class Task < ActiveRecord::Base
  belongs_to       :user
  validate         :url_correct
  after_initialize :task_init_url, :if => :new_record?
  after_create     :update_queue

  EXAMPLE_URLS = %w[http://vk.com/photo236886_332 http://vk.com/wall123123552]

  #
  # CRON: Update queue
  #
  def self.cron_update_queue
      @tasks = Task.where("active = ? AND likes = ?", true, 0)

      @tasks.each do |task|
        task.update_queue
      end
  end

  # Get new tasks
  def self.get_new_tasks(user, count = 1)
    new_tasks = Task.where("id > ? AND user_id!= ? AND active = ?", user['last_seen_task'], (user['id'].nil? ? 0 : user['id']), true)
                    .limit(count)
                    .order(:id)
    return new_tasks
  end

  # Shorten url
  def self.shorten_url(url)
    begin
      matches       = url.match %r{((photo|video|wall)[-]?[0-9]+[_][0-9]+)([\?]reply =[0-9]+)?}
      shortened_url = matches[1] + (!matches[3].nil? ? matches[3] : '')
      return shortened_url
    rescue
      return url
    end
  end

  # Verify likes
  def self.verify_likes(task_data)
    # warning count
    warnings = 0

    # valid task ids
    valid_task_ids ||= []

    # CHECK BLOCK
    task_data.each do |td|
      # check like time
      # (time from window.blur to window.focus)
      time = td['ts'] / 1000.0
      if time < 1.25 || time > (2 * 60)
        warnings += 1
        next
      end
      # check core engine
      if td['ce'] != '0x000'
        warnings += 1
        next
      end

      valid_task_ids << td['id']
    end

    valid_task_ids
  end

  #
  # Add likes to OTHERS
  #
  def self.like_others(valid_task_ids)
    return false if valid_task_ids.nil?

    # get tasks
    tasks = Task.where(id: valid_task_ids)

    # add likes to other tasks and disable queue, because the task is already liked
    tasks.update_all('likes = likes + 1, queue=0')

    # de-activate finished tasks
    tasks.where('likes>=need').update_all(:active => false)
  end

  # Report task
  def self.report(task_report_ids)
    return false if task_report_ids.nil?

    # increase reports
    Task.increment_counter(:reports, task_report_ids)

    # inactivate tasks with report limit
    Task.where(id: task_report_ids)
        .where('reports >= ?', 3)
        .update_all(:active => false)
  end

  #
  # Add likes to OWN current task
  #
  def add_needed(count)
    return false if count == 0

    self.need ||= 0
    self.need += count

    if self.need >= 3 && !self.active
      self.active = true
    end

    self.save
  end

  #
  # Get task stats
  #
  def self.get_stats(user_id)
    @tasks = Task.where('user_id = ?', user_id)
  end

  #
  # Update task queue
  #
  def update_queue
    queue = Task.where('active=:active AND likes=0 AND id < :id', {active: true, id: id}).count
    self.update_attribute(:queue, queue)
  end

  private
    # Create full, short and original urls for new record
    def task_init_url
      if valid?
        self.url_original = url
        self.url_short    = Task.shorten_url(self.url)
        self.url          = 'http://vk.com/' + url_short
      end
    end

    # Validate url
    def url_correct
      if url.blank?
        return errors.add :base, I18n.t('errors.blank_url')
      end

      if EXAMPLE_URLS.include?(url)
        return errors.add :base, I18n.t('errors.this_is_example')
      end

      if url.match('https?://(m.)?vk.com').nil?
        return errors.add :base, I18n.t('errors.should_start_with_vk_com')
      end

      if url.index('photo').nil? && url.index('video').nil? &&
        url.index('wall').nil? && url.index('_').nil?
        return errors.add :base, I18n.t('errors.specify_address')
      end
    end

end
