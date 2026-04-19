class FbColls {
  static const String users = 'users';
  static const String vehicles = 'vehicles';
  static const String conversations = 'conversations';
}

class FbSubColls {
  static const String convesationChats = 'chats';
}

class FbCommonKeys {
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String isActive = 'is_active';
}

class FBConvCollKeys {
  static const String aiChatId = 'ai_chat_id';
  static const String customerComplaint = 'customer_complaint';
  static const String customerName = 'customer_name';
  static const String initialFindings = 'initial_finding';
  static const String lastMessage = 'last_message';
  static const String lastSenderId = 'last_sender_id';
  static const String userId = 'user_id';
  static const String vehicleData = 'vehicle_data';
  static const String vehicleId = 'vehicle_id';
  static const String vin = 'vin';
  static const String status = 'status';
  static const String rating = 'rating';
  static const String remarks = 'remarks';
}

class FbConvChatCollKeys {
  static const String senderId = 'sender_id';
  static const String message = 'message';
}

class FbUserCollKeys {
  static const String id = 'id';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String emailId = 'email_id';
  static const String mobNum = 'mob_num';
  static const String profilePicUrl = 'profile_picture_url';
  static const String lastSeenOnline = 'last_seen_online';
  static const String conversationLimit = 'conversation_limit';
  static const String revenueCatEntitlement = 'revenue_cat_entitlement';
  static const String revenueCatEntitlementExpirationDate = 'revenue_cat_entitlement_expiration_date';
  static const String revenueCatEntitlementProductIdentifier = 'revenue_cat_entitlement_product_identifier';
  static const String revenueCatUserId = 'revenue_cat_user_id';
  static const String revenueCatRequestDate = 'revenue_cat_request_date';
  static const String revenueCatExpirationDates = 'revenue_cat_expiration_dates';
  static const String revenueCatLatestExpirationDate = 'revenue_cat_latest_expiration_date';
  static const String revenueCatManagementUrl = 'revenue_cat_latest_management_url';
  static const String brandOrIndependent = 'brand_or_independent';
  static const String shopName = 'shop_name';
  static const String yearStartedAsTechnician = 'year_started_as_technician';
}

class FbVehicleCollKeys {
  static const String userId = 'user_id';
  static const String initialFindings = 'initial_finding';
  static const String customerComplaint = 'customer_complaint';
  static const String customerName = 'customer_name';
  static const String vehicleData = 'vehicle_data';
  static const String vin = 'vin';
}