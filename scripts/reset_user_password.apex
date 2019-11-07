// NOTE: Update this query if you modify the config/users/... files
// TODO - is there a way to pass the values into this apex logic?
try {
  List<User> lusers = [Select Id, LastName from User where LastName = 'Ebikes' or LastName = 'Standard'];

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