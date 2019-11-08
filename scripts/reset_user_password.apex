// NOTE: Update this query if you modify the config/users/... files
try {
  List<User> lusers = [SELECT Id, LastName from User WHERE IsActive = True AND (LastName = 'SystemAdmin' OR LastName = 'StandardUser')];

  User tmp = new User();
  
  for (User usr : lusers) {
    System.resetPassword(usr.Id, true);
    System.debug('User Id: ' + usr.Id);
  }
} catch (Exception e) {
    System.debug('Exception during password reset');
    System.debug(logginglevel.INFO, '--- Message : ' + e.getMessage());
    System.debug(logginglevel.INFO, '--- Cause : ' + e.getCause());
    System.debug(logginglevel.INFO, '--- Type : ' + e.getTypeName());
}