Feature: Testing a Java project

  Background:
   Given the following test payload
     | repository | travis-ci/travis-ci                          |
     | commit     | 1234567                                      |
     | config     | language: java, java: openjdk6, env: FOO=foo |

  Scenario: A successful build with Maven
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it exports the line TRAVIS_JAVA_VERSION=openjdk6
     And it successfully switches to the java version: openjdk6
     And it announces active java version
     And it does not find the file build.gradle
     And it finds the file pom.xml
     And it successfully installs dependencies with maven
     And it successfully runs the script: mvn test
     And it closes the ssh session
     And it returns the result 0
     And it has captured the following events
       | name            | data                                       |
       | job:test:start  | started_at: [now]                          |
       | job:test:log    | log: /Using worker/                        |
       | job:test:log    | log: cd ~/builds                           |
       | job:test:log    | log: export FOO=foo                        |
       | job:test:log    | log: git clone                             |
       | job:test:log    | log: cd travis-ci/travis-ci                |
       | job:test:log    | log: git checkout                          |
       | job:test:log    | log: /export TRAVIS_JAVA_VERSION=openjdk6/ |
       | job:test:log    | log: sudo jdk-switcher use openjdk6        |
       | job:test:log    | log: java -version                         |
       | job:test:log    | log: mvn install --quiet -DskipTests=true  |
       | job:test:log    | log: mvn test                              |
       | job:test:log    | log: /Done.* 0/                            |
       | job:test:finish | finished_at: [now], result: 0              |

  Scenario: A successful build with Gradle
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it exports the line TRAVIS_JAVA_VERSION=openjdk6
     And it successfully switches to the java version: openjdk6
     And it announces active java version
     And it finds the file build.gradle
     And it successfully installs dependencies with gradle
     And it successfully runs the script: gradle check
     And it closes the ssh session
     And it returns the result 0
     And it has captured the following events
       | name            | data                                       |
       | job:test:start  | started_at: [now]                          |
       | job:test:log    | log: /Using worker/                        |
       | job:test:log    | log: cd ~/builds                           |
       | job:test:log    | log: export FOO=foo                        |
       | job:test:log    | log: git clone                             |
       | job:test:log    | log: cd travis-ci/travis-ci                |
       | job:test:log    | log: git checkout                          |
       | job:test:log    | log: /export TRAVIS_JAVA_VERSION=openjdk6/ |
       | job:test:log    | log: sudo jdk-switcher use openjdk6        |
       | job:test:log    | log: java -version                         |
       | job:test:log    | log: gradle assemble                       |
       | job:test:log    | log: gradle check                          |
       | job:test:log    | log: /Done.* 0/                            |
       | job:test:finish | finished_at: [now], result: 0              |

  Scenario: A successful build with Ant fallback
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it exports the line TRAVIS_JAVA_VERSION=openjdk6
     And it successfully switches to the java version: openjdk6
     And it announces active java version
     And it does not find the file build.gradle
     And it does not find the file pom.xml
     And it successfully runs the script: ant test
     And it closes the ssh session
     And it returns the result 0
     And it has captured the following events
       | name            | data                                       |
       | job:test:start  | started_at: [now]                          |
       | job:test:log    | log: /Using worker/                        |
       | job:test:log    | log: cd ~/builds                           |
       | job:test:log    | log: export FOO=foo                        |
       | job:test:log    | log: git clone                             |
       | job:test:log    | log: cd travis-ci/travis-ci                |
       | job:test:log    | log: git checkout                          |
       | job:test:log    | log: /export TRAVIS_JAVA_VERSION=openjdk6/ |
       | job:test:log    | log: sudo jdk-switcher use openjdk6        |
       | job:test:log    | log: java -version                         |
       | job:test:log    | log: ant test                              |
       | job:test:log    | log: /Done.* 0/                            |
       | job:test:finish | finished_at: [now], result: 0              |

  Scenario: The repository can not be cloned
    When it starts a job
    Then it exports the given environment variables
     And it fails to clone the repository to the build dir with git
     And it closes the ssh session
     And it returns the result 1

  Scenario: The commit can not be checked out
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it fails to check out the commit with git to the repository directory
     And it closes the ssh session
     And it returns the result 1

  Scenario: The java version can not be activated
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it exports the line TRAVIS_JAVA_VERSION=openjdk6
     And it fails to switch to the java version: openjdk6
     And it closes the ssh session
     And it returns the result 1

  Scenario: A failing build
    When it starts a job
    Then it exports the given environment variables
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it exports the line TRAVIS_JAVA_VERSION=openjdk6
     And it successfully switches to the java version: openjdk6
     And it announces active java version
     And it does not find the file build.gradle
     And it finds the file pom.xml
     And it successfully installs dependencies with maven
     And it fails to run the script: mvn test
     And it closes the ssh session
     And it returns the result 1
