require 'rails_helper'

RSpec.describe Test, :type => :model do

  before { @test = Test.new(title: "Sample Test", description: "Description of sample test") }

  subject { @test }

  it { should respond_to(:title)}
  it { should respond_to(:description)}

  #Conflict with the name Test

end
