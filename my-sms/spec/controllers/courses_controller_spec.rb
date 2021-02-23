# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:course) { create(:course) }

  describe 'GET #index' do
    subject { get :index }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('index')
    end
  end

  describe 'GET #show' do
    subject { get :show, { id: course.to_param } }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('show')
    end
  end

  describe 'GET #new' do
    subject { get :new }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('new')
    end
  end

  describe 'GET #edit' do
    subject { get :edit, { id: course.to_param } }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('edit')
    end
  end

  describe 'POST #create' do
    subject { post :create, { course: course } }

    context 'with valid params' do
      let(:course) { attributes_for(:course) }

      it 'creates a new Course' do
        expect { subject }.to change(Course, :count).by(1)
      end

      it 'redirects to the created course' do
        is_expected.to be_redirect
        is_expected.to redirect_to(Course.last)
      end
    end

    context 'with invalid params' do
      let(:course) { attributes_for(:course, start_date: nil) }

      it "returns a success response (i.e. to display the 'new' template)" do
        is_expected.to be_success
        is_expected.to render_template('new')
      end

      it 'does not create a new record' do
        expect { subject }.to_not change(Course, :count)
      end
    end
  end

  describe 'PUT #update' do
    let!(:course) { create(:course) }
    subject { put :update, { id: course.to_param, course: new_attributes } }

    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:course, {
                         name: 'Updated name',
                         description: 'Updated description',
                         allocation: 5
                       })
      end
      # let!(:course) do
      #   create(:course, first_name: 'John', last_name: 'New_name', gender: 'f')
      # end
      # let(:new_attributes) { attributes_for(:course).stringify_keys }
      let(:attr_names) do
        %w[
          allocation
          description
          name
          number_of_semesters
          start_date
          end_date
        ]
      end
      let(:new_attr_values) { new_attributes.stringify_keys.fetch_values(*attr_names) }

      it 'updates the requested course' do
        expect { subject }.to change {
          course.reload.attributes.fetch_values(*attr_names)
        }.to(new_attr_values)
      end

      it 'redirects to the course' do
        is_expected.to be_redirect
        is_expected.to redirect_to(course)
      end
    end

    context 'with invalid params' do
      let(:new_attributes) do
        attributes_for(:course, { end_date: 5.days.ago, start_date: 2.days.ago })
      end

      it "returns a success response (i.e. to display the 'edit' template)" do
        is_expected.to be_success
        is_expected.to render_template('edit')
      end

      it 'should propagate model errors to an error flash' do
        expect { subject }.to change { flash[:error] }.from(nil).to(['End date must be after start date'])
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:course) { create(:course) }
    subject { delete :destroy, { id: course.to_param } }

    # before { course }

    it 'destroys the requested course' do
      expect { subject }.to change(Course, :count).by(-1)
    end

    it 'redirects to the courses list' do
      is_expected.to be_redirect
      is_expected.to redirect_to(courses_url)
    end
  end
end
