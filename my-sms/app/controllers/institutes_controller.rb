# frozen_string_literal: false

class InstitutesController < ApplicationController
  decorates_assigned :institute

  before_filter :load_institute, except: %i[index]
  before_render :flash_errors, only: %i[edit create update]

  def index
    @institutes = InstituteDecorator.decorate_collection(
      Institute.paginate(page: params[:page], per_page: Institute::DEFAULT_PER_PAGE)
    )

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @institutes }
    end
  end

  def show; end

  def new; end

  def edit; end

  def create
    respond_to do |format|
      if @institute.save
        format.html { redirect_to @institute, notice: 'Institute was successfully created.' }
        format.json { render json: @institute, status: :created, location: @institute }
      else
        format.html { render action: 'new' }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @institute.update_attributes(params[:institute])
        format.html { redirect_to @institute, notice: 'Institute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @institute.destroy

    respond_to do |format|
      format.html { redirect_to institutes_url }
      format.json { head :no_content }
    end
  end

  def load_institute
    @institute = if params[:id]
                   Institute.find(params[:id])
                 else
                   Institute.new(params[:institute])
    end
  end

  def flash_errors
    super(@institute)
  end
end
