class MapLayerSource extends LayerSourceBase {
    mapObj := ""
    cloneData := false

    __New(mapObj, cloneData := true) {
        this.mapObj := mapObj
        this.cloneData := cloneData
    }

    SaveData(data := "") {
        if (!data) {
            data := Map()
        } else if (this.cloneData) {
            data := List.Clone(data, true)
        }

        this.mapObj := data

        return this
    }

    LoadData() {
        data := this.mapObj

        if (this.HasData() && this.cloneData) {
            data := List.Clone(data, true)
        }

        return data
    }

    HasData() {
        return !!(this.mapObj)
    }

    DeleteData() {
        if (this.HasData()) {
            this.mapObj := ""
        }
    }
}
