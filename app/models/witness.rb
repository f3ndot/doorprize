class Witness < ActiveRecord::Base
  
  belongs_to :incident, autosave: true

  validates :incident, presence: true, on: :update
  validates :name, presence: true

  def to_s
    name
  end

  def name
    if privacy_level == Witness.privacy_levels[:private]
      '(Withheld)'
    else
      read_attribute :name
    end
  end

  def contact
    if privacy_level == Witness.privacy_levels[:private]
      '(Withheld)'
    else
      read_attribute :contact
    end
  end

  def self.privacy_levels
    {public: 0, private: 1}
  end

  def private?
    privacy_level === Witness.privacy_levels[:private]
  end

  def public?
    not private?
  end

  def privacy
    case privacy_level
    when Witness.privacy_levels[:public]
      "Public"
    when Witness.privacy_levels[:private]
      "Private"
    end
  end

  def privacy=(level)
    return set_int_privacy(level) if level.is_a? Integer
    return set_string_privacy(level) if level.is_a? String
    return set_symbol_privacy(level) if level.is_a? Symbol
  end

  protected

  def set_int_privacy(level_int)
    write_attribute :privacy_level, level_int
  end

  def set_string_privacy(level_str)
    set_symbol_privacy level_str.downcase.to_sym
  end

  def set_symbol_privacy(level_sym)
    case level_sym
    when :public
      set_int_privacy Witness.privacy_levels[:public]
    when :private
      set_int_privacy Witness.privacy_levels[:private]
    end
  end

end
