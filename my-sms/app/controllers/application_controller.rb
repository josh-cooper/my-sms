# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  include AbstractController::Callbacks::ClassMethods

  define_callbacks :render

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
end
