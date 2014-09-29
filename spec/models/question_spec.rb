require 'rails_helper'

RSpec.describe Question, :type => :model do

  before { @question = Question.new(content:"how much is 2 + 2?", answer:1) }
  subject { @question }

  context 'given invalid fields' do
    it { should_not be_valid }
  end

  context 'given valid fields' do

    let(:exam) { FactoryGirl.create(:exam) }
    before do
      @question.exam = exam
    end

    it { should be_valid }

  end

  describe '#remove' do

    it {should respond_to(:remove)}

    it 'should delete' do
      expect(@question).to receive(:remove_from_list)
      expect(@question).to receive(:delete)
      @question.remove
    end

  end

end