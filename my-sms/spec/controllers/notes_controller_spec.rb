# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  let!(:note) { create(:note) }

  describe 'GET #show' do
    subject { get :show, { id: note.to_param } }
    it 'returns a success response' do
      is_expected.to be_success
      is_expected.to render_template('show')
    end
  end

  describe 'POST #create' do
    subject { post :create, { note: note, **notable_params } }
    let(:notable) { create(:student) }
    let(:notable_params) { { student_id: notable.to_param, notable_type: 'Student' } }

    context 'with valid params (on a student)' do
      let(:note) { attributes_for(:note) }

      it 'creates a new Note' do
        expect { subject }.to change(Note, :count).by(1)
      end

      it 'redirects to the notable' do
        is_expected.to be_redirect
        is_expected.to redirect_to(notable)
      end
    end

    context 'with invalid params' do
      let(:note) { attributes_for(:note, title: nil) }

      it 'redirects to the notable' do
        is_expected.to be_redirect
        is_expected.to redirect_to(notable)
      end

      it 'does not create a new record' do
        expect { subject }.to_not change(Note, :count)
      end

      it 'should propagate model errors to an error flash' do
        expect { subject }.to change { flash[:error] }.from(nil).to(["Title can't be blank"])
      end
    end
  end
end
