# <!-- BEGIN GENERATED ANNOTATION -->
# ## Schema Information
#
# Table name: `messages`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`body`**             | `text`             |
# **`conversation_id`**  | `integer`          |
# **`sender_id`**        | `integer`          |
# **`recipient_id`**     | `integer`          |
# **`type`**             | `integer`          |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_messages_on_conversation_id`:
#     * **`conversation_id`**
# * `index_messages_on_recipient_id`:
#     * **`recipient_id`**
# * `index_messages_on_sender_id`:
#     * **`sender_id`**
#
# ### Foreign Keys
#
# * `fk_rails_12e9de2e48`:
#     * **`recipient_id => users.id`**
# * `fk_rails_7f927086d2`:
#     * **`conversation_id => conversations.id`**
# * `fk_rails_b8f26a382d`:
#     * **`sender_id => users.id`**
#
# <!-- END GENERATED ANNOTATION -->

# # <!-- BEGIN GENERATED ANNOTATION -->
# # ## Schema Information
# #
# # Table name: `messages`
# #
# # ### Columns
# #
# # Name                   | Type               | Attributes
# # ---------------------- | ------------------ | ---------------------------
# # **`id`**               | `integer`          | `not null, primary key`
# # **`body`**             | `text`             |
# # **`conversation_id`**  | `integer`          |
# # **`sender_id`**        | `integer`          |
# # **`recipient_id`**     | `integer`          |
# # **`type`**             | `integer`          |
# # **`created_at`**       | `datetime`         | `not null`
# # **`updated_at`**       | `datetime`         | `not null`
# #
# # ### Indexes
# #
# # * `index_messages_on_conversation_id`:
# #     * **`conversation_id`**
# # * `index_messages_on_recipient_id`:
# #     * **`recipient_id`**
# # * `index_messages_on_sender_id`:
# #     * **`sender_id`**
# #
# # ### Foreign Keys
# #
# # * `fk_rails_12e9de2e48`:
# #     * **`recipient_id => users.id`**
# # * `fk_rails_7f927086d2`:
# #     * **`conversation_id => conversations.id`**
# # * `fk_rails_b8f26a382d`:
# #     * **`sender_id => users.id`**
# #
# # <!-- END GENERATED ANNOTATION -->
#
# require 'rails_helper'
#
# RSpec.describe Message, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
