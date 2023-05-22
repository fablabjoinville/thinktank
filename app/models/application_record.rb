class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.humanized_enum_value(enum, value)
    I18n.t("activerecord.attributes.#{name.underscore}.#{enum}.#{value}")
  end

  def humanized_enum(enum)
    I18n.t("activerecord.attributes.#{self.class.name.underscore}.#{enum}.#{send(enum)}")
  end
end
