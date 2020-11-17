# frozen_string_literal: true

require_relative 'type_handler'

module EnotasApi
  module Attributable
    def self.included(base)
      base.extend ClassMethods
    end

    def initialize(**attrs)
      set(attrs)
    end

    def attributes_changed
      (@attributes_changed || []).freeze
    end

    def attribute_changed?(attribute)
      attributes_changed.include?(attribute)
    end

    def attributes
      self.class.attributes
    end

    def set(attributes)
      return if attributes&.empty?

      attributes.each_pair do |attr, value|
        method = "#{attr}="
        method = attr unless respond_to?(method)
        send(method, value)
      end

      self
    end

    module ClassMethods
      def attribute(name, type)
        handler = EnotasApi::TypeHandler.new(type)

        (@attributes ||= {})[name] = type
        attr_reader name

        define_method "#{name}=" do |value|
          handler.validate!(value)

          instance_variable_set("@#{name}", handler.entity? && value.is_a?(Hash) ? type.new(value) : value)
          (@attributes_changed ||= []) << name
        end
      end

      def attributes
        (@attributes || {}).freeze
      end
    end
  end
end
