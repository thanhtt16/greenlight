# frozen_string_literal: true

# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
#
# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

class CompaniesController < ApplicationController
  include Pagy::Backend
  include Authenticator
  # POST /company
  def create
    @company = Company.new(company_params)
    @company.save
    flash[:success] = "Create company successfully"
    redirect_to admin_companies_path
  end

  # DELETE /company/:company_id
  def destroy
    @company = Company.find_by(id: params[:company_id])
    Company.destroy(params[:company_id])
    flash[:success] = "Delete company successfully"
    redirect_to admin_companies_path
  end

  # POST /company/edit/:company_id
  def update
    @company = Company.find_by(id: params[:company_id])
    @company.update_attributes(company_params)
    redirect_to admin_companies_path, flash: { success: I18n.t("info_update_success") }
  end

  # POST /company/remove_user/:company_id
  def remove_user
    @user = User.find_by(id: params[:user_id])
    @user.company_id = nil
    @user.save
    redirect_to admin_company_manage_user_path
  end

  def company_params
    params.require(:company).permit(:name, :description, :image)
  end
end
