import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl

def addPassword = { username, new_password ->
    def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
        com.cloudbees.plugins.credentials.common.StandardUsernameCredentials.class,
        Jenkins.instance
    )

    def c = creds.findResult { it.username == username ? it : null }

    if ( c ) {
        println "found credential ${c.id} for username ${c.username}"
    } else {
        def credentials_store = Jenkins.instance.getExtensionList(
            'com.cloudbees.plugins.credentials.SystemCredentialsProvider'
            )[0].getStore()

        def scope = CredentialsScope.GLOBAL

        def description = ""

        def result = credentials_store.addCredentials(
            com.cloudbees.plugins.credentials.domains.Domain.global(), 
            new UsernamePasswordCredentialsImpl(scope, null, description, username, new_password)
            )

        if (result) {
            println "credential added for ${username}" 
        } else {
            println "failed to add credential for ${username}"
        }
    }
}

addPassword("{{credential_user}}", "{{credential_password}}")
