# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `phone_numbers`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`user_id`**       | `integer`          | `not null`
# **`country_code`**  | `string`           | `not null`
# **`phone_number`**  | `string`           | `not null`
# **`authy_id`**      | `string`           | `not null`
# **`confirmed`**     | `boolean`          | `default(FALSE), not null`
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_phone_numbers_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_af796b956a`:
#     * **`user_id => users.id`**
#
# <!-- END GENERATED ANNOTATION -->

# # <!-- BEGIN GENERATED ANNOTATION -->
# # ## Schema Information
# #
# # Table name: `phone_numbers`
# #
# # ### Columns
# #
# # Name                | Type               | Attributes
# # ------------------- | ------------------ | ---------------------------
# # **`id`**            | `integer`          | `not null, primary key`
# # **`user_id`**       | `integer`          | `not null`
# # **`country_code`**  | `string`           | `not null`
# # **`phone_number`**  | `string`           | `not null`
# # **`authy_id`**      | `string`           | `not null`
# # **`confirmed`**     | `boolean`          | `default(FALSE), not null`
# # **`created_at`**    | `datetime`         | `not null`
# # **`updated_at`**    | `datetime`         | `not null`
# #
# # ### Indexes
# #
# # * `index_phone_numbers_on_user_id`:
# #     * **`user_id`**
# #
# # ### Foreign Keys
# #
# # * `fk_rails_af796b956a`:
# #     * **`user_id => users.id`**
# #
# # <!-- END GENERATED ANNOTATION -->
#
# require 'rails_helper'
#
# RSpec.describe PhoneNumber, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
