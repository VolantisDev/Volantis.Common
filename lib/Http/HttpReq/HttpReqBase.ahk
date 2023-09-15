class HttpReqBase {
    url := ""
    timeout := -1
    proxy := ""
    codepage := ""
    charset := ""
    saveAs := ""
    response := ""
    statusCode := 0
    responseData := ""
    requestHeaders := Map()
    responseHeaders := ""
    responseBody := ""
    autoRedirect := true
    pos := ""
    returnCode := ""

    __New(url) {
        this.url := url
    }

    /**
    * ABSTRACT METHODS
    */

    Send(method := "GET", data := "") {
        throw MethodNotImplementedException("HttpReqBase", "Send")
    }

    Get(data := "") {
        this.Send("GET", data)
        return this.GetResponseData()
    }

    Post(data := "") {
        this.Send("POST", data)
        return this.GetResponseData()
    }

    Put(data := "") {
        this.Send("PUT", data)
        return this.GetResponseData()
    }

    Delete(data := "") {
        this.Send("DELETE", data)
        return this.GetResponseData()
    }

    /**
    * IMPLEMENTED METHODS
    */

    GetStatusCode() {
        return this.statusCode
    }

    GetReturnCode() {
        return this.returnCode
    }

    GetResponseBody() {
        return this.responseBody
    }

    GetResponseData() {
        return this.responseData
    }
}
