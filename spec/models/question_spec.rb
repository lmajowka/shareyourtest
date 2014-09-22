require 'rails_helper'

RSpec.describe Question, :type => :model do

  before { @question = Question.new(content:"how much is 2 + 2?", answer:1) }

  subject { @question }

  context 'given valid fields'

    let(:exam) { FactoryGirl.create(:exam) }

    before do
      @question.exam = exam
    end

    it { should be_valid }

end