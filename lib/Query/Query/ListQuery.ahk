class ListQuery extends QueryBase {
    listObj := ""

    __New(listObj := "", resultType := "") {
        this.SetList(listObj)
        super.__New(resultType)
    }

    SetList(listObj := "") {
        if (listObj == "") {
            listObj := []
        }

        if (listObj.HasBase(Map.Prototype) || listObj.HasBase(Array.Prototype)) {
            throw DataException("ListQuery: listObj must be a map or array.")
        }

        this.listObj := listObj
    }

    getStorageDefinitions() {
        return this.listObj
    }
}
