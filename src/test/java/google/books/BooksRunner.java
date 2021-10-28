package google.books;

import com.intuit.karate.junit5.Karate;

class BooksRunner {

    @Karate.Test
    Karate testAPI() {
        return Karate.run("books").relativeTo(getClass());
    }
}
