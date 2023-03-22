pipeline {
    agent any
    tools { 
      maven 'MAVEN_HOME' 
      jdk 'JAVA_HOME' 
    }
    stages {
        stage('compile') {
		   steps {
					echo 'compiling..'
					git url: 'https://github.com/kpashindla29/spring-to-aws-demo-new-3'
					sh 'mvn compile'
				 }
		}
        stage('codereview-pmd') {
		   steps {
					echo 'codereview..'
					sh 'mvn -P metrics pmd:pmd'
			   }
		   post {
				   success {
					   pmd canComputeNew: false, defaultEncoding: '', healthy: '', pattern: '**/pmd.xml', unHealthy: ''
				   }
			   }		
		}
        stage('unit-test') {
		   steps {
					echo 'codereview..'
					sh 'mvn test'
			   }
		   post {
				   success {
					   junit 'target/surefire-reports/*.xml'
				   }
			   }			
			}
        stage('metric-check') {
		   steps {
					echo 'unit test..'
					sh 'mvn verify'
				}
		   post {
				   success {
						
						jacoco(
							execPattern: '**/target/**.exec',
							classPattern: '**/target/classes',
							sourcePattern: '**/src',
							inclusionPattern: 'com/ab/**',
							changeBuildStatus: true
						)
				   }
			   }		
        }
        stage('package') {
		   steps {
					echo 'metric-check..'
					sh 'mvn package'	
			   }		
        }
    }
}