# ## Schema Information
#
# Table name: `profiles`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `integer`          | `not null, primary key`
# **`name`**              | `string`           |
# **`bio`**               | `text`             |
# **`work_company`**      | `string`           |
# **`work_title`**        | `string`           |
# **`location`**          | `string`           |
# **`twitter_username`**  | `string`           |
# **`rate_email`**        | `decimal(, )`      | `default(0.0), not null`
# **`rate_sms`**          | `decimal(, )`      | `default(0.0), not null`
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
# **`user_id`**           | `integer`          |
#
# ### Indexes
#
# * `index_profiles_on_twitter_username`:
#     * **`twitter_username`**
# * `index_profiles_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_e424190865`:
#     * **`user_id => users.id`**
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
