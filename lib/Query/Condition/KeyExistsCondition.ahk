class KeyExistsCondition extends ConditionBase {
    listObj := ""

    __New(listObj, childConditions := "", negate := false) {
        this.listObj := listObj
        super.__New(childConditions, negate)
    }

    EvaluateCondition(val) {
        return this.listObj.Has(val)
    }
}
