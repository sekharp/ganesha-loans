class CartProject < SimpleDelegator
  attr_reader :project,
              :amount

  def initialize(project, amount = 0)
    @project = project
    @amount = amount
    super(@project)
  end
end
