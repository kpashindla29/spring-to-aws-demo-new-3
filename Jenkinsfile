pipeline {
    agent any
    tools { 
      maven 'MAVEN_HOME' 
      jdk 'JAVA_HOME' 
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/kpashindla29/spring-to-aws-demo-new-3'
            }
        }
        
        stage('Compile') {
            steps {
                echo 'compiling..'
                sh 'mvn compile'
            }
        }
        
        stage('Code Review (PMD)') {
            steps {
                echo 'codereview..'
                sh 'mvn pmd:pmd'
            }
            post {
                success {
                    recordIssues enabledForFailure: true, tool: pmdParser(pattern: '**/target/pmd.xml')
                }
            }       
        }
        
        stage('Test with Clover') {
            steps {
                echo 'running tests with clover..'
                // Use the coverage profile - NO instrumentation element in pom.xml
                sh 'mvn test -Pcoverage'
                sh 'mvn clover:clover clover:aggregate -Pcoverage'
            }
        }
        
        stage('Publish Clover Report') {
            steps {
                clover(
                    cloverReportDir: 'target/site/clover', 
                    cloverReportFileName: 'clover.xml',
                    healthyTarget: [methodCoverage: 70, conditionalCoverage: 80, statementCoverage: 80],
                    unhealthyTarget: [methodCoverage: 50, conditionalCoverage: 50, statementCoverage: 50],
                    failingTarget: [methodCoverage: 0, conditionalCoverage: 0, statementCoverage: 0]
                )
            }
        }
        
        stage('Package') {
            steps {
                echo 'packaging..'
                sh 'mvn package'    
            }       
        }
    }
}
