/*
 * Project      : my_coffee
 * File         : get_transaction_id.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-19
 * Version      : 1.0
 * Ticket       : 
 */

String getTransactionId(String url) {
  // The URL
  // String url = "https://app.senangpay.my/result?&status_id=1&order_id=5e0d25ec-e98b-44c9-b951-04a1cd40c57d&transaction_id=1732011800009507219&msg=Payment_was_successful&hash=c149318fd96704782738011d3f76c29dbc3e6b427b36cdccee7e278dac689704";

  // Parse the URL
  Uri uri = Uri.parse(url);

  // Extract the 'transaction_id' query parameter
  String? transactionId = uri.queryParameters['transaction_id'];

  // Print the result
  if (transactionId != null) {
    print("Transaction ID: $transactionId");
    return transactionId??'';
  } else {
    print("Transaction ID not found in the URL.");
    return '';
  }
}