class QueryBase {
    resultType := ""
    conditions := []
    results := ""
    executed := false

    static RESULT_TYPE_KEYS := "keys"
    static RESULT_TYPE_VALUES := "values"

    __New(resultType := "") {
        if (!resultType) {
            resultType := QueryBase.RESULT_TYPE_KEYS
        }

        this.resultType := resultType
    }

    SetResultType(resultType) {
        this.resultType := resultType
    }

    /**
     * Adds a condition to the query.
     *
     * Condition should be an instance of a ConditionBase or QueryConditionBase object.
     *
     * If a field is provided, the condition will be wrapped in a FieldCondition object and the value
     * will be assumed to be map-like.
     *
     * If no field is provided, the condition will be wrapped in an IdCondition object and it will
     * be assumed the key is being searched
     *
     * If the field is the special value {}, the condition will not be wrapped and the value itself
     * will be searched directly.
     */
    Condition(condition, field := "", params*) {
        if (!condition.HasBase(ConditionBase.Prototype)) {
            throw QueryException("Provided condition is not of correct type. Provided type was: " . Type(condition))
        }

        condition := this.preprocessCondition(condition, field, params*)

        if (condition) {
            this.conditions.Push(condition)
        }

        return this
    }

    preprocessCondition(condition, field := "", params*) {
        if (!condition.HasBase(QueryConditionBase.Prototype)) {
            if (field == "{}") {
                condition := this.getIdCondition(condition, params*)
            } else {
                condition := this.getFieldCondition(condition, field, params*)
            }
        }

        return condition
    }

    getIdCondition(condition, params*) {
        return IdCondition(condition)
    }

    getFieldCondition(condition, field, params*) {
        return FieldCondition(condition, field)
    }

    Matches(pattern, field := "", params*) {
        return this.Condition(MatchesCondition(pattern), field, params*)
    }

    RegEx(pattern, field := "", params*) {
        return this.Condition(RegExCondition(pattern), field, params*)
    }

    StartsWith(pattern, field := "", params*) {
        return this.Condition(StartsWithCondition(pattern), field, params*)
    }

    EndsWith(pattern, field := "", params*) {
        return this.Condition(EndsWithCondition(pattern), field, params*)
    }

    Contains(pattern, field := "", params*) {
        return this.Condition(ContainsCondition(pattern), field, params*)
    }

    Execute() {
        this.initializeResults()

        for key, definition in this.getStorageDefinitions() {
            if (this.ValidateItem(key, definition) && this.matchesQuery(key, definition)) {
                this.addResult(key, definition)
            }
        }

        this.executed := true
        return this.GetResults()
    }

    /**
     * Checks if the item is of the correct type for this query.
     */
    ValidateItem(key, definition) {
        return true
    }

    GetResults() {
        return this.results
    }

    initializeResults() {
        this.results := []
    }

    getStorageDefinitions() {

    }

    matchesQuery(itemKey, itemDefinition) {
        matches := this.conditions.Length == 0 ? true : false

        for index, condition in this.conditions {
            matches := condition.Evaluate(itemKey, itemDefinition)

            if (!matches) {
                break
            }
        }

        return matches
    }

    addResult(itemKey, itemDefinition) {
        if (this.resultType == QueryBase.RESULT_TYPE_VALUES) {
            this.results.Push(itemDefinition)
        } else if (this.resultType == QueryBase.RESULT_TYPE_KEYS) {
            this.results.Push(itemKey)
        } else {
            throw QueryException("Unknown result type: " . this.resultType)
        }
    }
}
