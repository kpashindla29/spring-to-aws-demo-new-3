pipeline {
    agent any
    stages {
        stage('compile') {
		   steps {
					echo 'compiling..'
					git url: 'https://github.com/kpashindla29/spring-to-aws-demo-new-3'
					'mvn compile'
				 }
		}
        stage('codereview-pmd') {
		   steps {
					echo 'codereview..'
					'mvn -P metrics pmd:pmd'
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
					'mvn test'
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
					'mvn verify'
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
					'mvn package'	
			   }		
        }
    }
}