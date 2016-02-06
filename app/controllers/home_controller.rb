class HomeController < ApplicationController
  def home
    @top_projects = top_projects
  end

  private

  def top_projects
    active = Project.where(status: "Active")
    h = active.map { |proj| [proj, proj.percent_funded]}.to_h
    ordered = h.max_by(3) { |k,v| v }
  end
end
