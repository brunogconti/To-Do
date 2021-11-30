module ApplicationHelper
  def alert_class(flash_name)
    if flash_name == '#7B68EE'
      'class-one'
    elsif flash_name == '#6A5ACD'
      'class-two'
    elsif flash_name == '#800000'
      'class-three'
    elsif flash_name == '#2F4F4F'
      'class-four'
    end
  end
end
