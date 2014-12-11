class PivotalTrackerUrlValidator < ActiveModel::Validator
  def validate(record)
    if record.pivotaltracker_url.present?
      if(pivotal_url?(record))
        validate_pivotal_tracker_url(record)
      else
        validate_jira_url(record)
      end
    end  
  end
  def pivotal_url?(record)
    url = record.pivotaltracker_url
    url.match(/^(?:https|http|)[:\/]*www\.pivotaltracker\.com\/[n|s]\/projects\/(\d+)$/i) || \
      url.match(/^\d+$/)
  end

  private

  def validate_pivotal_tracker_url(record)
    url = record.pivotaltracker_url
    match = url.match(/^(?:https|http|)[:\/]*www\.pivotaltracker\.com\/[n|s]\/projects\/(\d+)$/i)
    if match.present?
      pv_id = match.captures[0]
    elsif url =~ /^\d+$/
      pv_id = url
    end

    if pv_id.present?
      # tidy up URL
      record.pivotaltracker_url = "https://www.pivotaltracker.com/s/projects/#{pv_id}"
    else
      record.errors[:pivotaltracker_url] << 'Invalid Pivotal Tracker URL'
    end
  end

  def validate_jira_url(record)
    url = record.pivotaltracker_url
    match = url.match(/^(?:https|http|)[:\/]*(\w+)\.atlassian.net\/secure\/.*/i)
    unless match.present?
      record.errors[:pivotaltracker_url] << 'Invalid JIRA URL'
    end
  end
end
