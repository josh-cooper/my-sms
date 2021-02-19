# frozen_string_literal: false

class CoursesController < ApplicationController
  decorates_assigned :course

  before_filter :load_course, except: %i[index]

  # GET /courses
  # GET /courses.json
  def index
    @courses = CourseDecorator.decorate_collection(
      Course.paginate(page: params[:page], per_page: Course::DEFAULT_PER_PAGE)
    )

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit; end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def load_course
    @course = if params[:id]
                Course.find(params[:id])
              else
                Course.new(params[:course])
    end
  end
end
