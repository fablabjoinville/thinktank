class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.humanized_enum_value(enum, value)
    I18n.t("activerecord.attributes.#{name.underscore}.#{enum.to_s.pluralize}.#{value}")
  end

  def self.humanized_enum_list(enum, *keys)
    enum_keys = self.public_send(enum).keys.map(&:to_sym)
    enum_keys = enum_keys.select { |k| keys.include?(k) } if keys.present?
    enum_keys.map { |k| [self.humanized_enum_value(enum, k), k] }
  end

  def self.humanized(count)
    model_name.human(count: count)
  end

  def humanized_enum(enum)
    I18n.t("activerecord.attributes.#{self.class.name.underscore}.#{enum.to_s.pluralize}.#{send(enum)}")
  end

  def humanized(count)
    self.class.model_name.human(count: count)
  end

end
