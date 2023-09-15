class ListFilter extends ListQuery {
    __New(listObj := "") {
        resultType := QueryBase.RESULT_TYPE_VALUES

        if (listObj.HasBase(Map.Prototype)) {
            resultType := QueryBase.RESULT_TYPE_KEYS
        }

        super.__New(listObj, resultType)
    }

    GetResults() {
        results := this.results
        newResults := ""

        if (this.listObj.HasBase(Map.Prototype)) {
            newResults := Map()

            for , key in results {
                newResults[key] := this.listObj[key]
            }

            results := newResults
        }

        return results
    }
}
