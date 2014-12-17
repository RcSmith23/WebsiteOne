require 'spec_helper'

describe PivotalTrackerUrlValidator do
  let(:dummy_class) do
    Class.new do
      include ActiveModel::Validations
      attr_accessor :pivotaltracker_url
      validates_with PivotalTrackerUrlValidator
      def pivotaltracker_url? do
        
      end
    end
  end

  subject { dummy_class.new }

  ['https://www.pivotaltracker.com/s/projects/982890', 'https://www.pivotaltracker.com/n/projects/982890'].each do |valid_url|
    it "#{valid_url} is a valid pivotal project url" do
      subject.pivotaltracker_url = valid_url
      expect(subject).to be_valid
    end
  end

  it 'should be valid for a valid JIRA project url' do
    subject.pivotaltracker_url = 'https://osraav.atlassian.net/secure/RapidBoard.jspa?rapidView=2'
    expect(subject).to be_valid
  end

  ['http://github.com/AgileVentures/WebsiteOne','<>hi' \
    ,'https://www.pivotaltracker.com/t/projects/982890'].each do |invalid_url|
    it "#{invalid_url.inspect} is an invalid url" do
      subject.pivotaltracker_url = invalid_url
      expect(subject.errors).not_to be_valid
    end
  end

end
