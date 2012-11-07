module ApplicationHelper
  def activate(name)
    "active" if controller_name == name
  end
end
