const LOGIN = '/auth/login';
const REGISTER = '/auth/signup';
const QUESTION = '/user/question';

String ANSWER({required String id}) => '/user/search/${id}';
