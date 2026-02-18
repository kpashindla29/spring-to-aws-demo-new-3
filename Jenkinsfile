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
				   	recordIssues enabledForFailure: true, tool: pmdParser(pattern: '**/target/pmd.xml')
				   }
			   }		
		}
        stage('Test') {
		      steps {
		        sh 'mvn clean clover:setup test clover:aggregate clover:clover'
		      }
    	}
        stage('Report') {
		  steps {
	        clover(cloverReportDir: 'target/site', cloverReportFileName: 'clover.xml',
	          // optional, default is: method=70, conditional=80, statement=80
	          healthyTarget: [methodCoverage: 70, conditionalCoverage: 80, statementCoverage: 80],
	          // optional, default is none
	          unhealthyTarget: [methodCoverage: 50, conditionalCoverage: 50, statementCoverage: 50],
	          // optional, default is none
	          failingTarget: [methodCoverage: 0, conditionalCoverage: 0, statementCoverage: 0]
	        )
	      }
		}
        stage('package') {
		   steps {
					echo 'packaging..'
					sh 'mvn package'	
			   }		
        }
        
        
    }
}
