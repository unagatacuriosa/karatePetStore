package examples.users.pet;

import com.intuit.karate.junit5.Karate;

public class PetRunner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("pet").relativeTo(getClass());
    }
}
