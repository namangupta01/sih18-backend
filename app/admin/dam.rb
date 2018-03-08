ActiveAdmin.register Dam do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :name_of_dam, :operated_and_maintained_by, :longitude_of_dam, :latitude_of_dam, :year_of_completion, :river_basin, :river, :nearest_city, :seismic_zone, :type_of_dam, :height_above_lowest_foundation, :length_of_dam, :volume_content_of_dam, :gross_storage_capacity, :reservoir_area, :effective_storage_capacity, :purpose, :designed_spillway_capacity, :state, :present_water_level
end
