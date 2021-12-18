# Record Service
class RecordCreator
  def initialize(attributes = {})
    @event_type = attributes[:event_type]
    @task = attributes[:task]
    @properties = {}
  end

  def create_record
    record = Record.create!(
      event_type: @event_type,
      properties: { message: set_message, color: set_color },
      task: @task
    )
    record.properties['message']
  end

  private

  def set_message
    case @event_type
    when 'Congratulations'
      set_congrats
    when 'Shame'
      set_shame
    end
  end

  def set_congrats
    case @task.updated_at.strftime('%A')
    when 'Monday'
      'Muito bem!'
    when 'Tuesday'
      'Isso aí!'
    when 'Wednesday'
      'Boa!'
    when 'Thursday'
      'Parabéns!'
    when 'Friday'
      'Parabéns!'
    else
      'Que coisa boa!'
    end
  end

  def set_shame
    ['Poxa...', 'Que pena!', '🤦‍♂️', 'Má notícia', 'Isso é ruim'].sample
  end

  def set_color
    ['#7B68EE', '#6A5ACD', '#800000', '#2F4F4F'].sample
  end
end
