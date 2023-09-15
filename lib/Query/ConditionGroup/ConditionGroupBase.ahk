/*
    All condition groups should extend this class so that code can check if
    it is a container group or a condition itself.
*/
class ConditionGroupBase extends ConditionBase {
    /**
     * Many condition groups serve as containers so only their child conditions matter.
     * If the group itself matters, override this method.
     */
    EvaluateCondition(args*) {
        return true
    }
}
