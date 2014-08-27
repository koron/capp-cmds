#include <stdio.h>
#include <jansson/jansson.h>

int main(int argc, char** argv) {
    json_t *obj, *arr1;

    obj = json_object();
    arr1 = json_array();
    json_object_set(obj, "foo", arr1);
    json_decref(arr1);

    printf("%s", json_dumps(obj, JSON_INDENT(2)));

    json_decref(obj);

    return 0;
}
