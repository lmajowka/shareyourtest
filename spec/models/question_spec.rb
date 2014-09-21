require 'rails_helper'

RSpec.describe Question, :type => :model do

  before { @question = Question.new(content:"how much is 2 + 2?", answer:1) }

  subject { @question }

  it { should_not be_valid }

  #context 'given valid fields'

    #let(:test) { FactoryGirl.create(:test) }
    #
    #before do
    #  @question.test = test
    #end
    #
    #it { should be_valid }

end