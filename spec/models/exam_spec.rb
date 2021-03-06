require 'rails_helper'

RSpec.describe Exam, :type => :model do

  before { @test = Exam.new(title: "Sample Test", description: "Description of sample test") }

  subject { @test }

  it { should respond_to(:title)}
  it { should respond_to(:description)}

  context 'given valid attributes'

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      @test.owner = user
    end

    it { should be_valid }


end
