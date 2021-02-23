# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  include AbstractController::Callbacks::ClassMethods

  define_callbacks :render

  DEFAULT_PER_PAGE = 10

  def self.before_render(*names, &blk)
    _insert_callbacks(names, blk) do |name, options|
      set_callback(:render, :before, name, per_key: options.fetch(:per_key, {}))
    end
  end

  def render(*args)
    run_callbacks :render do
      super(*args)
    end
  end

  def flash_errors(model_instance)
    return unless model_instance&.errors&.full_messages

    model_instance.errors.full_messages.each do |error|
      (flash[:error] ||= []) << error
    end
  end
end
