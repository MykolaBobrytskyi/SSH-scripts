def login_data = "\'{\"email\": \"\", \"password\": \"\"}\'"
def baseUrl = ""
proc = ['bash', '-c', "curl -s -X POST -H \"accept: application/json\" -H \"Content-Type: application/json\" -d ${login_data} ${baseUrl}auth/login/"].execute() |'jq -e .access_token'.execute() |'xargs'.execute()
proc.waitFor()
def output = proc.in.text
File file = new File("token")
file.write output
print file.text



//-----------------------------------------------------------
//===========================================================

// receiveToken("${env.API_BASE_URL}", "${env.USER_EMAIL}", "${env.USER_PASSWORD}")
// prepareQuery("${env.API_BASE_URL}", "${params.DOMAIN_NAME}")
// postMetrics("${env.API_BASE_URL}")

// def receiveToken(baseUrl, userEmail, userPassword){
//   try {
//     def loginData = "\'{\"email\": \"${userEmail}\", \"password\": \"${userPassword}\"}\'"
//     def proc = ['bash', '-c', "curl -s -X POST -H \"accept: application/json\" -H \"Content-Type: application/json\" -d ${loginData} ${baseUrl}auth/login/"].execute() |'/usr/bin/jq -e .access_token'.execute() |'xargs'.execute()
//     proc.waitFor()
//     def output = proc.in.text
//     File tokenFile = new File("token")
//     tokenFile.write output
//     print tokenFile.text
//   } catch (Exception ex) {
//     println "Failed to receive token. Please check the provided credentials and/or the backend availability."
//     throw ex
//   }
// }
//
// def prepareQuery(baseUrl, domain){
//   try {
//     sh """curl -s -X GET ${baseUrl}domains/ -H "accept: application/json" -H "Authorization: Token `cat token`" > domains
//           jq -e .version ./mrnn/metrics.json |xargs > version
//           jq -rce . ./mrnn/metrics.json |cat > validation_metrics
//           jq . domains |grep -B 1 ${domain} |grep -E id |awk \'{print \$2}\' |rev |cut -c 2- |rev > domain_id
//        """
//   } catch (Exception ex) {
//     println "Failed to fetch details for a query."
//     throw ex
//   }
// }
//
// def postMetrics(baseUrl){
//   try {
//     sh """curl -s -X POST ${baseUrl}naas_models/ \
//             -H "accept: application/json" \
//             -H "Content-Type: application/json" \
//             -H "Authorization: Token `cat token`" \
//             -d "{ \"version\": \"`cat version`\", \"validation_metrics\": `cat validation_metrics`, \"domain\": \"`cat domain_id`\"}"
//           rm token domains version validation_metrics domain_id
//        """
//   } catch (Exception ex) {
//     println "Failed to post model metrics to DB."
//     throw ex
//   }
// }
//===========================================================
//-----------------------------------------------------------

// def env = System.getenv()
//Print all the environment variables.

// env.each{
// println it
// }
// def s3Bucket = "some_bucket_name"
// print s3Bucket
// def domainsList = '/usr/local/bin/aws s3api list-objects-v2 --bucket ${s3Bucket} --output text --delimiter /'.execute() | '/usr/bin/cut -d / -f 1'.execute() | 'sed 1d'.execute()
// domainsList.waitFor()
// def output = domainsList.in.text
// print output.split('COMMONPREFIXES')


// import hudson.slaves.EnvironmentVariablesNodeProperty
// import hudson.EnvVars
// EnvironmentVariablesNodeProperty prop = Jenkins.instance.getGlobalNodeProperties().get(EnvironmentVariablesNodeProperty.class)
// EnvVars env = prop.getEnvVars()
// def MY_VAR = env['USER']
// println MY_VAR


// def env = System.getenv("USER")
// println env


// more tries
// import jenkins.model.*
//
// // this will print out the requested var from the global Jenkins config
// // def envVars = Jenkins.instance.getGlobalNodeProperties()[0].getEnvVars()
// // println envVars['test_key']
//
// def envVars = Jenkins.instance.getNodeProperties()[0].getEnvVars()
// println envVars['S3_BUCKET']
