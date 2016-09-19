# # <!-- BEGIN GENERATED ANNOTATION -->
# # ## Schema Information
# #
# # Table name: `social_media_accounts`
# #
# # ### Columns
# #
# # Name              | Type               | Attributes
# # ----------------- | ------------------ | ---------------------------
# # **`id`**          | `integer`          | `not null, primary key`
# # **`user_id`**     | `integer`          |
# # **`platform`**    | `integer`          | `not null`
# # **`username`**    | `string`           | `not null`
# # **`url`**         | `string`           | `not null`
# # **`proof`**       | `string`           |
# # **`confirmed`**   | `boolean`          | `default(FALSE), not null`
# # **`created_at`**  | `datetime`         | `not null`
# # **`updated_at`**  | `datetime`         | `not null`
# #
# # ### Indexes
# #
# # * `index_social_media_accounts_on_user_id`:
# #     * **`user_id`**
# #
# # ### Foreign Keys
# #
# # * `fk_rails_19f1549559`:
# #     * **`user_id => users.id`**
# #
# # <!-- END GENERATED ANNOTATION -->
#
# require 'rails_helper'
# RSpec.describe SocialMediaAccount, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
