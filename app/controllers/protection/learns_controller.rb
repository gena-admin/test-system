class Protection::LearnsController < Protection::ApplicationController
  def new
    @question = ProtectionQuestion.first(:offset => rand(ProtectionQuestion.count))
  end
end
