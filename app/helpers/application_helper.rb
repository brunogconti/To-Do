module ApplicationHelper
  def alert_class(flash_name)
    if flash_name == :one
      'class-one'
    elsif flash_name == :two
      'class-two'
    elsif flash_name == :three
      'class-three'
    elsif flash_name == :four
      'class-four'
    end
  end
end
