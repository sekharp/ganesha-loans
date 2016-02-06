class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def add_project(project_id, amount)
    contents[project_id.to_s] ||= 0
    contents[project_id.to_s] += amount
  end

  def update_loan(project_id, amount)
    contents[project_id.to_s] = amount
    remove_project(project_id) if contents[project_id.to_s] < 1
  end

  def remove_project(project_id)
    contents.delete(project_id.to_s)
  end

  def total_count
    contents.count
  end

  def total_amount
    contents.values.reduce(:+)
  end

  def amount_of(project_id)
    contents[project_id.to_s]
  end

  def projects
    contents.map do |project_id, amount|
      project = Project.find(project_id)
      CartProject.new(project, amount)
    end
  end
end
