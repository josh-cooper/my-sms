# frozen_string_literal: true

class NotesController < ApplicationController
  before_filter :load_note

  def create
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note.notable, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        # propagate note errors to root model, if possible
        flash_errors(@note)
        format.html { redirect_to :back }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  def load_note
    @note = if params[:id]
              Note.find(params[:id])
            else
              note = Note.new(params[:note])
              notable_type = params[:notable_type]
              note[:notable_type] = notable_type
              note[:notable_id] = notable_type && params["#{notable_type.downcase}_id"]
              note
    end
  end
end
